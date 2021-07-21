package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.config.auth.LoginUser;
import com.rocketdan.serviceserver.config.auth.dto.SessionUser;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

// 페이지에 관련된 컨트롤러는 모두 IndexController를 사용.
@RequiredArgsConstructor
@Controller
public class IndexController {
    @GetMapping("/")
    // @LoginUser SessionUser user
    // * 어느 컨트롤러든지 @LoginUser만 사용하면 세션 정보를 가져올 수 있다.
    public void index(Model model, @LoginUser SessionUser user) {
        // if (user != null)
        // * 세션에 저장된 값이 있을 때만 model에 userName으로 등록한다.
        // * 세션에 저장된 값이 없으면 model엔 아무런 값이 없는 상태이니 로그인 버튼이 보이게 된다.
//        if (user != null) {
//            model.addAttribute("userName", user.getName());
//        }
    }
}
