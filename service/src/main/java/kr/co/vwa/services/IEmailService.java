package kr.co.vwa.services;

/**
 * Created by junypooh on 2018-02-09.
 * <pre>
 * kr.co.vwa.services
 *
 * Email Interface
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-02-09 오후 12:57
 */
public interface IEmailService {

    /**
     * 일반 메일 발송
     * @param to
     * @param subject
     * @param text
     */
    void sendEmailMessage(String to, String subject, String text);

    /**
     * MIME type 메일 발송
     * @param to
     * @param name
     * @param subject
     * @param text
     */
    void sendEmailMimeMessage(String to, String name, String subject, String text);
}
