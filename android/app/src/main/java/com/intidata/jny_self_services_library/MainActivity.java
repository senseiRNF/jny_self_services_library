package com.intidata.jny_self_services_library;

import android.Manifest;
import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.LocationManager;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.provider.Settings;
import android.widget.Toast;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

import com.rscja.deviceapi.RFIDWithUHFBLE;
import com.rscja.deviceapi.entity.UHFTAGInfo;
import com.rscja.deviceapi.interfaces.ConnectionStatus;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "intidata.android/library_app";
    private static final String EVENT_NAME = "intidata.android/library_app_event";
    public static final String SHOW_HISTORY_CONNECTED_LIST = "showHistoryConnectedList";

    public boolean isScanning = false;

    private static final int ACCESS_FINE_LOCATION_PERMISSION_REQUEST = 100;
    private static final int WRITE_EXTERNAL_STORAGE_PERMISSION_REQUEST = 101;
    private static final int READ_EXTERNAL_STORAGE_PERMISSION_REQUEST = 102;
    private static final int REQUEST_ENABLE_BT = 1;
    private static final int REQUEST_ACTION_LOCATION_SETTINGS = 3;
    private static final int FLAG_START = 0;
    private static final int FLAG_STOP = 1;
    private static final int FLAG_UHFINFO = 2;
    private static final int FLAG_SUCCESS = 3;
    private static final int FLAG_FAIL = 4;
    private static final int FLAG_TIME_OVER = 5;

    public BluetoothAdapter mBtAdapter = null;

    public RFIDWithUHFBLE uhf = RFIDWithUHFBLE.getInstance();

    private final Handler handler = new Handler(Looper.getMainLooper()) {
        @Override
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case FLAG_STOP:
                    if (msg.arg1 != FLAG_SUCCESS) {
                        Utils.playSound(getApplicationContext(), 2);

                        Toast.makeText(getApplicationContext(), "Stop failure", Toast.LENGTH_SHORT).show();
                    } else {
                        Utils.playSound(getApplicationContext(), 1);
                    }

                    break;
                case FLAG_START:
                    if (msg.arg1 != FLAG_SUCCESS) {
                        Utils.playSound(getApplicationContext(), 2);
                    } else {
                        Utils.playSound(getApplicationContext(), 1);
                    }

                    break;
                case FLAG_UHFINFO:
                    UHFTAGInfo info = (UHFTAGInfo) msg.obj;

                    if(info != null && attachEvent != null) {
                        attachEvent.success(info.getEPC());
                    }

                    break;
            }
        }
    };

    private EventChannel.EventSink attachEvent;

    private void checkLocationEnable() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            if (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                requestPermissions(new String[]{Manifest.permission.ACCESS_FINE_LOCATION}, ACCESS_FINE_LOCATION_PERMISSION_REQUEST);
            }
        } else {
            if (!isLocationEnabled()) {
                Utils.alert(this, "Get location permission", "Do you enter the settings interface to open the location permission?", R.drawable.webtext,
                        (dialog, which) -> {
                            Intent intent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);

                            startActivityForResult(intent, REQUEST_ACTION_LOCATION_SETTINGS);
                        });
            }
        }
    }

    private void checkReadWritePermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            if (!Environment.isExternalStorageManager()) {
                Intent intent = new Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION);
                intent.setData(Uri.parse("package:" + getPackageName()));

                startActivityForResult(intent, 0);
            }
        } else {
            if (checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
                requestPermissions(new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, WRITE_EXTERNAL_STORAGE_PERMISSION_REQUEST);
            }

            if (checkSelfPermission(Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
                requestPermissions(new String[]{Manifest.permission.READ_EXTERNAL_STORAGE}, READ_EXTERNAL_STORAGE_PERMISSION_REQUEST);
            }
        }
    }

    private boolean isLocationEnabled() {
        LocationManager lm = (LocationManager) getSystemService(LOCATION_SERVICE);

        return lm.isLocationEnabled();
    }

    private void stopInventory() {
        ConnectionStatus connectionStatus = uhf.getConnectStatus();

        if(connectionStatus != ConnectionStatus.CONNECTED){
            return;
        }

        boolean result;

        result = uhf.stopInventory();

        Message msg = handler.obtainMessage(FLAG_STOP);

        if (!result) {
            msg.arg1 = FLAG_FAIL;
        } else {
            msg.arg1 = FLAG_SUCCESS;
        }

        handler.sendMessage(msg);
    }

    //--------------------> Channel To Flutter <--------------------//

    private String read() {
        String result = "";

        if(uhf.getConnectStatus() == ConnectionStatus.CONNECTED) {
            result = uhf.readData("00000000", RFIDWithUHFBLE.Bank_EPC, 2, 4);
        }

        return result;
    }

    private boolean write(String data) {
        boolean result = false;

        if(uhf.getConnectStatus() == ConnectionStatus.CONNECTED) {
            result = uhf.writeData("00000000", RFIDWithUHFBLE.Bank_EPC, 2, 4, data);
        }

        return result;
    }

    private void setConnectedBluetooth(String address) {
        if (uhf.getConnectStatus() == ConnectionStatus.CONNECTING) {
            Toast.makeText(getApplicationContext(), "Connecting...", Toast.LENGTH_SHORT).show();
        } else {
            uhf.connect(address);
        }
    }

    private void removeConnectedBluetooth() {
        if (uhf.getConnectStatus() == ConnectionStatus.CONNECTED) {
            uhf.disconnect();
        }
    }

    public void startThread() {
        if (isScanning) {
            return;
        }

        uhf.setPower(15);
        uhf.setFrequencyMode(0x08);

        int idx = uhf.getRFLink();
        uhf.setRFLink(idx);

        uhf.setEPCMode();
        uhf.setSupportRssi(true);
        uhf.setFilter(RFIDWithUHFBLE.Bank_EPC, 0, 0, "");

        uhf.setInventoryCallback(uhftagInfo -> handler.sendMessage(handler.obtainMessage(FLAG_UHFINFO, uhftagInfo)));

        isScanning = true;

        Message msg = handler.obtainMessage(FLAG_START);

        if (uhf.startInventoryTag()) {
            msg.arg1 = FLAG_SUCCESS;
        } else {
            msg.arg1 = FLAG_FAIL;

            isScanning = false;
        }

        handler.sendMessage(msg);
    }

    private void stop() {
        handler.removeMessages(FLAG_TIME_OVER);

        if(isScanning) {
            stopInventory();

            attachEvent.endOfStream();
        }

        isScanning = false;
    }

    //--------------------> Channel To Flutter <--------------------//

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(
                flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL
        ).setMethodCallHandler((call, result) -> {
            switch (call.method) {
                case "init":
                    checkLocationEnable();
                    checkReadWritePermission();

                    mBtAdapter = BluetoothAdapter.getDefaultAdapter();

                    uhf.init(getApplicationContext());

                    result.success(true);
                    break;
                case "setConnectedBluetooth":
                    setConnectedBluetooth(call.argument("address"));

                    result.success(true);
                    break;
                case "removeConnectedBluetooth":
                    removeConnectedBluetooth();

                    result.success(true);
                case "readRFID":
                    if(uhf.getConnectStatus() == ConnectionStatus.CONNECTED) {
                        String rfidResult = read();

                        result.success(rfidResult);
                    } else {
                        String rfidResult = "null";

                        result.success(rfidResult);
                    }
                    break;
                case "writeRFID":
                    if(uhf.getConnectStatus() == ConnectionStatus.CONNECTED) {
                        boolean writeResult = write(call.argument("newRFID"));

                        if(writeResult) {
                            result.success(true);
                        } else {
                            result.error("WRITE_FAILED", "Failed to write data", null);
                        }
                    } else {
                        result.error("BT_DISCONNECTED", "Bluetooth Device Not Found", null);
                    }
                    break;
                default:
                    break;
            }
        });

        new EventChannel(
                flutterEngine.getDartExecutor().getBinaryMessenger(), EVENT_NAME
        ).setStreamHandler(
                new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object arguments, EventChannel.EventSink events) {
                        attachEvent = events;

                        startThread();
                    }

                    @Override
                    public void onCancel(Object arguments) {
                        stop();

                        attachEvent = null;

                        Toast.makeText(getApplicationContext(), "Listener ended", Toast.LENGTH_SHORT).show();
                    }
                }
        );
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_ENABLE_BT) {
            if (resultCode == Activity.RESULT_OK) {
                Toast.makeText(this, "Bluetooth has turned on", Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(this, "Problem in BT Turning ON ", Toast.LENGTH_SHORT).show();
            }
        }
    }

    @Override
    protected void onDestroy() {
        uhf.free();

        super.onDestroy();
    }
}
