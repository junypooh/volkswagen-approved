package kr.co.vwa.services;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;

/**
 * Created by junypooh on 2018-02-09.
 * <pre>
 * kr.co.vwa.services
 *
 * Email Service
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-02-09 오후 12:56
 */
@Service
public class EmailService implements IEmailService {

    @Autowired
    private JavaMailSender javaMailSender;

    @Value("${spring.mail.sendAddr}")
    private String from;

    /**
     * 메일 발송
     * @param to
     * @param subject
     * @param text
     */
    @Override
    @Transactional(readOnly = true)
    public void sendEmailMessage(String to, String subject, String text) {

        SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
        simpleMailMessage.setTo(to);
        simpleMailMessage.setFrom(from);
        simpleMailMessage.setSubject(subject);
        simpleMailMessage.setText(text);

        javaMailSender.send(simpleMailMessage);
    }

    /**
     * MIME type 메일 발송
     * @param to
     * @param name
     * @param subject
     * @param text
     */
    @Override
    @Transactional(readOnly = true)
    public void sendEmailMimeMessage(String to, String name, String subject, String text) {

        try {
            MimeMessage mimeMessage = javaMailSender.createMimeMessage();
            mimeMessage.setSubject(subject, "UTF-8");

            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
            helper.setFrom(from);
            helper.setTo(to);
            if(StringUtils.isNotBlank(name)) {
                helper.setTo(new InternetAddress(to, name, "UTF-8"));
            } else {
                helper.setTo(to);
            }
            helper.setText(text, true);

            javaMailSender.send(mimeMessage);

        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }
}
