package com.intidata.jny_self_services_library;

import static android.content.Context.AUDIO_SERVICE;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.media.AudioManager;
import android.media.SoundPool;

import java.util.HashMap;

public class Utils {
    public static void alert(Activity act, String titleInt, String message, int iconInt, DialogInterface.OnClickListener positiveListener) {
        try {
            AlertDialog.Builder builder = new AlertDialog.Builder(act);
            builder.setTitle(titleInt);
            builder.setMessage(message);
            builder.setIcon(iconInt);

            builder.setNegativeButton("Close", (dialog, which) -> dialog.dismiss());
            if (positiveListener != null) {
                builder.setPositiveButton("OK", positiveListener);
            }
            builder.create().show();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void playSound(Context context, int id) {
        final HashMap<Integer, Integer> soundMap = new HashMap<>();

        SoundPool soundPool = new SoundPool.Builder().setMaxStreams(10).build();

        soundMap.put(1, soundPool.load(context, R.raw.barcodebeep, 1));
        soundMap.put(2, soundPool.load(context, R.raw.serror, 1));

        AudioManager am = (AudioManager) context.getSystemService(AUDIO_SERVICE);

        float audioMaxVolume = am.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
        float audioCurrentVolumn = am.getStreamVolume(AudioManager.STREAM_MUSIC);

        float volumnRatio = audioCurrentVolumn / audioMaxVolume;

        try {
            //noinspection DataFlowIssue
            soundPool.play(soundMap.get(id), volumnRatio, volumnRatio, 1, 0, 1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
