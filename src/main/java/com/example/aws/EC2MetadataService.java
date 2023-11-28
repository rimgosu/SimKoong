package com.example.aws;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class EC2MetadataService {

    private final String METADATA_URL = "http://169.254.169.254/latest/meta-data/";
    private final String TOKEN_URL = "http://169.254.169.254/latest/api/token";
    private final int TOKEN_TTL_SECONDS = 21600; // 6 hours

    public String getEC2InstancePublicIPv4() {
        try {
            String token = getMetadataToken();
            return getMetadata("public-ipv4", token);
        } catch (Exception e) {
            // Handle the exception as appropriate
            // For example, log the error or throw a custom exception
            throw new RuntimeException("Error retrieving EC2 instance public IPv4", e);
        }
    }

    private String getMetadataToken() throws Exception {
        URL url = new URL(TOKEN_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("PUT");
        conn.setRequestProperty("X-aws-ec2-metadata-token-ttl-seconds", String.valueOf(TOKEN_TTL_SECONDS));
        conn.connect();

        if (conn.getResponseCode() != 200) {
            throw new RuntimeException("Failed to get token: HTTP error code : " + conn.getResponseCode());
        }

        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            return br.readLine();
        } finally {
            conn.disconnect();
        }
    }

    private String getMetadata(String metadataPath, String token) throws Exception {
        URL url = new URL(METADATA_URL + metadataPath);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestProperty("X-aws-ec2-metadata-token", token);
        conn.connect();

        if (conn.getResponseCode() != 200) {
            throw new RuntimeException("Failed to get metadata: HTTP error code : " + conn.getResponseCode());
        }

        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            StringBuilder metadataValue = new StringBuilder();
            String output;
            while ((output = br.readLine()) != null) {
                metadataValue.append(output);
            }
            return metadataValue.toString();
        } finally {
            conn.disconnect();
        }
    }
}
