package com.rocketdan.serviceserver.firebase.controller;

import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.rocketdan.serviceserver.core.CommonResponse;
import com.rocketdan.serviceserver.firebase.dto.PushMessageRequestDto;
import com.rocketdan.serviceserver.firebase.dto.UserPushTokenResponseDto;
import com.rocketdan.serviceserver.firebase.service.FirebaseCloudMessageService;
import com.rocketdan.serviceserver.firebase.service.UserPushTokenService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/push")
public class FirebaseCloudMessageController {
    private final FirebaseCloudMessageService fcmService;

    private final UserPushTokenService userPushTokenService;

    @Value("${fcm.properties.firebase-multicast-message-size}")
    Long multicastMessageSize;

    @PostMapping("/topics/{topic}")
    public void notificationTopics(@PathVariable String topic, @RequestBody PushMessageRequestDto requestDto) throws FirebaseMessagingException {
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
    @PostMapping("/users/{user_id}")
    public CommonResponse notificationUser(@PathVariable Long user_id, @RequestBody PushMessageRequestDto requestDto) throws FirebaseMessagingException {
        UserPushTokenResponseDto userPushToken = userPushTokenService.findByUserId(user_id);
        if (userPushToken.getAllowed()) {
            notification(requestDto, userPushToken);
            return CommonResponse.builder()
                    .message("Push notification.")
                    .code("PUSH_SUCCESS")
                    .status(200)
                    .data(user_id)
                    .build();
        }
        return CommonResponse.builder()
                .message("User didn't allow push notification.")
                .code("PUSH_SUCCESS")
                .status(200)
                .data(user_id)
                .build();
    }

    @PostMapping("/stores/{store_id}")
    public CommonResponse notificationStore(@PathVariable Long store_id, @RequestBody PushMessageRequestDto requestDto) throws FirebaseMessagingException {
        UserPushTokenResponseDto userPushToken = userPushTokenService.findByStoreId(store_id);
        if (userPushToken.getAllowed()) {
            notification(requestDto, userPushToken);
            return CommonResponse.builder()
                    .message("Push notification.")
                    .code("PUSH_SUCCESS")
                    .status(200)
                    .data(store_id)
                    .build();
        }
        return CommonResponse.builder()
                .message("User didn't allow push notification.")
                .code("PUSH_SUCCESS")
                .status(200)
                .data(store_id)
                .build();
    }

    private void notification(PushMessageRequestDto requestDto, UserPushTokenResponseDto userPushToken) throws FirebaseMessagingException {
        Notification notification = Notification.builder().setTitle(requestDto.getTitle()).setBody(requestDto.getBody()).setImage(requestDto.getImage()).build();

        Message.Builder builder = Message.builder();
        Optional.ofNullable(requestDto.getData()).ifPresent(builder::putAllData);

        Message msg = builder.setToken(userPushToken.getPushToken()).setNotification(notification).build();

        fcmService.sendMessage(msg);
    }
}
