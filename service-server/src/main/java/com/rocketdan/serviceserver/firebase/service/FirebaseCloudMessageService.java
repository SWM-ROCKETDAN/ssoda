package com.rocketdan.serviceserver.firebase.service;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.util.List;

@Service
public class FirebaseCloudMessageService {
    @Value("${fcm.properties.firebase-create-scoped}")
    String fireBaseCreateScoped;

    private FirebaseMessaging instance;

    public void sendTargetMessage(String targetToken, String title, String body) throws FirebaseMessagingException {
        this.sendTargetMessage(targetToken, title, body, null);
    }
    public void sendTargetMessage(String targetToken, String title, String body, String image) throws FirebaseMessagingException {
        Notification notification = Notification.builder().setTitle(title).setBody(body).setImage(image).build();
        Message msg = Message.builder().setToken(targetToken).setNotification(notification).build();
        sendMessage(msg);
    }

    public void sendTopicMessage(String topic, String title, String body) throws FirebaseMessagingException {
        this.sendTopicMessage(topic, title, body, null);
    }
    public void sendTopicMessage(String topic, String title, String body, String image) throws FirebaseMessagingException {
        Notification notification = Notification.builder().setTitle(title).setBody(body).setImage(image).build();
        Message msg = Message.builder().setTopic(topic).setNotification(notification).build();
        sendMessage(msg);
    }

    public String sendMessage(Message message) throws FirebaseMessagingException {
        return this.instance.send(message);
    }

    @PostConstruct
    public void firebaseSetting() throws IOException {
        String firebaseConfigPath = "firebaseServiceKey.json";

        // GoogleCredentials
        // : GoogleApi를 사용하기 위해서 oauth2를 이용해 인증한 대상을 나타내는 객체
        // fromStream
        // : firebaseServiceKey.json의 inputStream을 넣으면 인스턴스를 얻을 수 있다.
        // createScoped
        // : 인증하는 서버에서 필요로하는 권한을 지정 아래 링크에서 scope 확인 가능
        // https://developers.google.com/identity/protocols/oauth2/scopes#fcm
        GoogleCredentials googleCredentials = GoogleCredentials.fromStream(new ClassPathResource(firebaseConfigPath).getInputStream())
                .createScoped((List.of(fireBaseCreateScoped)));

        FirebaseOptions secondaryAppConfig = FirebaseOptions.builder()
                .setCredentials(googleCredentials)
                .build();
        FirebaseApp app = FirebaseApp.initializeApp(secondaryAppConfig);
        this.instance = FirebaseMessaging.getInstance(app);
    }

    public BatchResponse sendMessage(MulticastMessage message) throws FirebaseMessagingException {
        return this.instance.sendMulticast(message);
    }
}
