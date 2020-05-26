package com.dm.sche.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.dm.sche.constant.Constant;
import com.dm.sche.constant.UserConstant;

@Configuration
public class SecuritySuccessHandler implements AuthenticationSuccessHandler {

	@Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws ServletException, IOException {

		response.setStatus(HttpServletResponse.SC_OK);
        response.sendRedirect("/" + Constant.VIEWS + "/dashboard");
    }

}
