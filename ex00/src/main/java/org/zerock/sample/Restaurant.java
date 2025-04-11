package org.zerock.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Setter;


// @Controller, @Service, @Repositry, @Component, @RestController, @~Advice
@Component
@Data
public class Restaurant {

	// 자동 DI
	// lombok and Spring : @Setter(onMethod_ = @Autowired)
	// Spring : @Autowired
	// JAVA : @Inject (lombok 처럼 라이브러리가 있어야 사용할 수 있다.)
	@Setter(onMethod_ = @Autowired)
	private Chef chef;
}
