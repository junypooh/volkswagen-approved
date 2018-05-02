package kr.co.vwa.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Created by junypooh on 2017-12-18.
 * 엑셀필드명
 */
@Target({ ElementType.FIELD })
@Retention(RetentionPolicy.RUNTIME)
public @interface ExcelFieldName {

    /**
     * 엑셀 필드 명
     */
    String name() default "";

    /**
     * 필드 순서
     */
    int order() default -1;

    /**
     * boolean 필드 일 경우 엑셀에 노출한 값 (/ 로 구분)
     * ex. 예/아니오
     */
    String booleanValue() default "";
}
