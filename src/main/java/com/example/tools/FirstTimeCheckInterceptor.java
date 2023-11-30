package com.example.tools;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.security.CustomUser;

@Component
public class FirstTimeCheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null && authentication.getPrincipal() instanceof CustomUser) {
            CustomUser userDetails = (CustomUser) authentication.getPrincipal();
            if (userDetails.getInfo().getIsFirst()) {
                response.sendRedirect("/photoUpload");
                return false;
            }
        }

        return true;
    }
}
