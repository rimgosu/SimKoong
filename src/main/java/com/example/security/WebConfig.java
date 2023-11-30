package com.example.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.resource.PathResourceResolver;

import com.example.tools.FirstTimeCheckInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {
	
	@Autowired
	private FirstTimeCheckInterceptor firstTimeCheckInterceptor;

	String[] resourcePaths = { "css", "js", "img", "Logintemplate", "webjars", "Jointemplate", "lib", "scss", "video"};
	
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/")
                .setCachePeriod(3600)
                .resourceChain(true)
                .addResolver(new PathResourceResolver() {
                    @Override
                    protected Resource getResource(String resourcePath, Resource location) throws IOException {
                        Resource requestedResource = location.createRelative(resourcePath);
                        return requestedResource.exists() && requestedResource.isReadable() ? requestedResource
                                : null;
                    }
                });
    }
    

	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		List<String> resourcePatterns = new ArrayList<>();

		for (String path : resourcePaths) {
			resourcePatterns.add("/" + path + "/**");
		}

		registry.addInterceptor(firstTimeCheckInterceptor)
				.excludePathPatterns(
					"/photoUpload", 
					"/logout", 
					"/login",
					"/fileUpload",
					"/update",
					"/location",
					"/error",
					"/"
				)
				.excludePathPatterns(resourcePatterns); // 동적으로 생성된 패턴 사용
	}

}
