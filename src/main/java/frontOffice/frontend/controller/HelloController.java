package frontOffice.frontend.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HelloController {

    @GetMapping("/hello")
    public String hello(Model model) {
        String message = "Hello World depuis le controller";
        model.addAttribute("message", message);
        return "hello"; // résout vers /WEB-INF/jsp/hello.jsp
    }

}
