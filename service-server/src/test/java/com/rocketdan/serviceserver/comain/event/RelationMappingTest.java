package com.rocketdan.serviceserver.comain.event;


import com.rocketdan.serviceserver.domain.event.EventRepository;
import com.rocketdan.serviceserver.domain.event.reward.Reward;
import com.rocketdan.serviceserver.domain.event.reward.RewardRepository;
import com.rocketdan.serviceserver.domain.event.type.Hashtag;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Date;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class RelationMappingTest {
    @Autowired
    private EventRepository eventRepository;

    @Autowired
    private RewardRepository rewardRepository;

    @Test
    public void testOneToManyInsert() {
        Reward reward1 = new Reward(1, "name1", "img1", 1000, 100);
        Reward reward2 = new Reward(2, "name2", "img2", 2000, 50);
        rewardRepository.save(reward1);
        rewardRepository.save(reward2);

        Hashtag event1 = new Hashtag("title1", 1, new Date(), new Date(), List.of("img1", "img2"),
                List.of(reward1, reward2), List.of("hello", "hi"), List.of(true, false, true), 1);

        eventRepository.save(event1);

        Reward reward3 = new Reward(3, "name3", "img3", 3000, 25);
        Reward reward4 = new Reward(4, "name4", "img4", 4000, 12);
        rewardRepository.save(reward3);
        rewardRepository.save(reward4);

        Hashtag event2 = new Hashtag("title2", 1, new Date(), new Date(), List.of("img3", "img4"),
                List.of(reward3, reward4), List.of("bonjour", "안녕"), List.of(false, false, false), 1);

        eventRepository.save(event2);
    }
}
