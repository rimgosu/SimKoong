package com.example.aws;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class EC2Migration {

	// os 이름 추출
	public String osName = System.getProperty("os.name").toLowerCase();
	private static final String EC2_PUBLIC_IP_URL = "http://169.254.169.254/latest/meta-data/public-ipv4";
	
	// s3-key 속성 가져오기
	public String s3keyPath() {
		if (this.osName.contains("win")) {
			return "/keys/s3/s3-keys.json";
		} else {
			return "/keys/s3/s3-keys.json";
		}
	}
	
	public String cassandraConfigPath() {
		if (this.osName.contains("win")) {
			return "/keys/keyspace/application.conf";
		} else {
			return "/keys/keyspace/application.conf";
		}
	}
	
	public String ipv4() {
		if (this.osName.contains("win")) {
			return "localhost";
		} else {
			return "3.34.134.84";
		}
	}
	
	public String getEC2PublicIP() {
        try {
            URL url = new URL(EC2_PUBLIC_IP_URL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuilder content = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }
            in.close();
            con.disconnect();

            return content.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
	
}
