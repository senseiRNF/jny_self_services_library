package com.intidata.jny_self_services_library;

import android.os.Environment;
import android.util.Xml;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlSerializer;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;

public class FileUtils {
    public static String ADDR = "btaddress";
    public static String NAME = "btname";
    public static String filePath = Environment.getExternalStorageDirectory() + File.separator + "BTDeviceList.xml";

    public static void saveXmlList(List<String[]> data) {
        try {
            File file = new File(filePath);

            if (file.exists()) {
                boolean deleteResult = file.delete();

                if(deleteResult) {
                    FileOutputStream fos = new FileOutputStream(file);

                    XmlSerializer serializer = Xml.newSerializer();

                    serializer.setOutput(fos, "utf-8");
                    serializer.startDocument("utf-8", true);
                    serializer.startTag(null, "root");

                    for (int i = 0; i < data.size(); i++) {
                        serializer.startTag(null, "bt");
                        // 蓝牙地址
                        serializer.startTag(null, ADDR);
                        serializer.text(data.get(i)[0]);
                        serializer.endTag(null, ADDR);
                        // 蓝牙名称
                        serializer.startTag(null, NAME);
                        serializer.text(data.get(i)[1]);
                        serializer.endTag(null, NAME);
                        serializer.endTag(null, "bt");
                    }

                    serializer.endTag(null, "root");
                    serializer.endDocument();
                    fos.close();
                }
            } else {
                FileOutputStream fos = new FileOutputStream(file);

                XmlSerializer serializer = Xml.newSerializer();

                serializer.setOutput(fos, "utf-8");
                serializer.startDocument("utf-8", true);
                serializer.startTag(null, "root");

                for (int i = 0; i < data.size(); i++) {
                    serializer.startTag(null, "bt");
                    // 蓝牙地址
                    serializer.startTag(null, ADDR);
                    serializer.text(data.get(i)[0]);
                    serializer.endTag(null, ADDR);
                    // 蓝牙名称
                    serializer.startTag(null, NAME);
                    serializer.text(data.get(i)[1]);
                    serializer.endTag(null, NAME);
                    serializer.endTag(null, "bt");
                }

                serializer.endTag(null, "root");
                serializer.endDocument();
                fos.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static ArrayList<String[]> readXmlList() {
        ArrayList<String[]> list = new ArrayList<>();
        try {
            File path = new File(filePath);
            if (!path.exists()) {
                return list;
            }
            FileInputStream fis = new FileInputStream(path);

            XmlPullParser parser = Xml.newPullParser();

            parser.setInput(fis, "utf-8");

            int eventType = parser.getEventType();

            String addr = null;
            String name = null;

            while (eventType != XmlPullParser.END_DOCUMENT) {
                String tagName = parser.getName();
                switch (eventType) {
                    case XmlPullParser.START_TAG:
                        if (ADDR.equals(tagName)) { // <name>
                            addr = parser.nextText();
                        } else if (NAME.equals(tagName)) { // <age>
                            name = parser.nextText();
                        }
                        break;
                    case XmlPullParser.END_TAG: // </persons>
                        if ("bt".equals(tagName)) {
                            String[] str = new String[2];

                            str[0] = addr;
                            str[1] = name;

                            list.add(str);
                        }
                        break;
                    default:
                        break;
                }
                eventType = parser.next(); // 获得下一个事件类型
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static void clearXmlList() {
        List<String[]> list = readXmlList();
        list.clear();
        saveXmlList(list);
    }
}
