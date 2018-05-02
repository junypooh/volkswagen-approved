package kr.co.vwa.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Created by junypooh on 2018-02-28.
 * <pre>
 * kr.co.vwa.annotation
 *
 * Web Log Aspect 처리 annotation
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-02-28 오후 3:26
 */
@Target({ ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
public @interface WebLogInfo {

    String menuPath() default "";
}
