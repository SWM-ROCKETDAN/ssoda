package com.rocketdan.serviceserver.firebase.controller;

import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.rocketdan.serviceserver.domain.user.pushToken.UserPushToken;
import com.rocketdan.serviceserver.firebase.dto.PushMessageRequestDto;
import com.rocketdan.serviceserver.firebase.service.FirebaseCloudMessageService;
import com.rocketdan.serviceserver.firebase.service.UserPushTokenService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/push")
public class FirebaseCloudMessageController {
    private final FirebaseCloudMessageService fcmService;

    UserPushTokenService userPushTokenService;

    @Value("${fcm.properties.firebase-multicast-message-size}")
    Long multicastMessageSize;

    @PostMapping(value = "/topics/{topic}")
    public void notificationTopics(@PathVariable("topic") String topic, @RequestBody PushMessageRequestDto requestDto) throws FirebaseMessagingException {
        Notification notification = Notification.builder().setTitle(requestDto.getTitle()).setBody(requestDto.getBody()).setImage(requestDto.getImage()).build();
        Message.Builder builder = Message.builder();

        Optional.ofNullable(requestDto.getData()).ifPresent(builder::putAllData);
        Message msg = builder.setTopic(topic).setNotification(notification).build();
        fcmService.sendMessage(msg);
    }
/*
    @PostMapping(value = "/users")
    public void notificationUsers(@RequestBody PushMessagesRequestDto requestDto) throws IOException, FirebaseMessagingException {
        // userIds가 있다면 해당 user에 push 알림 전송, 없다면 모든 user에 push 알림 전송
        List<User> targetUser = (null == requestDto.getUserIds() ? userService.findAllByEnabledAndPushTokenIsNotNull(UseCd.USE001) : userService.findAllByEnabledAndPushTokenIsNotNullAndNoIn(UseCd.USE001, requestDto.getUserIds()));

        AtomicInteger counter = new AtomicInteger();
        Collection<List<User>> sendUserGroups = targetUser.stream().collect(Collectors.groupingBy(it -> counter.getAndIncrement() / multicastMessageSize)).values();

        for (List<User> it : sendUserGroups) {

            Notification notification = Notification.builder().setTitle(requestDto.getTitle()).setBody(requestDto.getBody()).setImage(requestDto.getImage()).build();
            MulticastMessage.Builder builder = MulticastMessage.builder();
            Optional.ofNullable(requestDto.getData()).ifPresent(builder::putAllData);
            MulticastMessage message = builder
                    .setNotification(notification)
                    .addAllTokens(it.stream().map(sit ->
                        userPushTokenService.findByUserId(sit.getUserId()).getPushToken()).collect(Collectors.toList()))
                    .build();
            this.fcmService.sendMessage(message);
        }
    }
*/
    @PostMapping(value = "/users/{userId}")
    public void notificationUser(@PathVariable("userId") Long userId, @RequestBody PushMessageRequestDto requestDto) throws FirebaseMessagingException {
        UserPushToken userPushToken = userPushTokenService.findByUserId(userId);

        Notification notification = Notification.builder().setTitle(requestDto.getTitle()).setBody(requestDto.getBody()).setImage(requestDto.getImage()).build();

        Message.Builder builder = Message.builder();
        Optional.ofNullable(requestDto.getData()).ifPresent(builder::putAllData);

        Message msg = builder.setToken(userPushToken.getPushToken()).setNotification(notification).build();

        fcmService.sendMessage(msg);
    }
}
