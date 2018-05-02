package kr.co.vwa.web.controller;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.NotImplementedException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.net.URLDecoder;
import java.util.Enumeration;

/**
 * Created by junypooh on 2018-02-27.
 * <pre>
 * kr.co.vwa.web.controller
 *
 * Proxy Controller
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-02-27 오전 10:40
 */
@Controller
public class ProxyController {

    /**
     * Stream Proxy
     * @param url
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "proxy/image")
    public void imageProxyCall(@RequestParam(required = true, value = "url") String url, HttpServletRequest request, HttpServletResponse response) throws IOException {

        // URL needs to be url decoded
        url = URLDecoder.decode(url, "utf-8").replaceAll("&amp;", "&");
        HttpClient client = new HttpClient();

        HttpMethod method = null;

        // Split this according to the type of request
        if (request.getMethod().equals("GET")) {
            method = new GetMethod(url);
        } else {
            throw new NotImplementedException("This proxy only supports only GET methods.");
        }

        // Execute the method
        client.executeMethod(method);

        // Set the content type, as it comes from the server
        Header[] headers = method.getResponseHeaders();
        for (Header header : headers) {
            if ("Content-Type".equalsIgnoreCase(header.getName())) {
                response.setContentType(header.getValue());
            }
        }

        InputStream inputStream = method.getResponseBodyAsStream();
        IOUtils.copy(inputStream, response.getOutputStream());
    }

    /**
     * 일반 Proxy
     * @param url
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "proxy")
    public void proxyCall(@RequestParam(required = true, value = "url") String url, HttpServletRequest request, HttpServletResponse response) throws IOException {

        // URL needs to be url decoded
        url = URLDecoder.decode(url, "utf-8").replaceAll("&amp;", "&");

        OutputStreamWriter writer = new OutputStreamWriter(response.getOutputStream());
        HttpClient client = new HttpClient();
        try {

            HttpMethod method = null;

            // Split this according to the type of request
            if (request.getMethod().equals("GET")) {

                method = new GetMethod(url);

            } else if (request.getMethod().equals("POST")) {

                method = new PostMethod(url);

                // Set any eventual parameters that came with our original // request (POST params, for instance)
                Enumeration paramNames = request.getParameterNames();
                while (paramNames.hasMoreElements()) {
                    String paramName = (String) paramNames.nextElement();
                    ((PostMethod) method).setParameter(paramName, request.getParameter(paramName));
                }

            } else {

                throw new NotImplementedException("This proxy only supports GET and POST methods.");
            }

            // Execute the method
            client.executeMethod(method);

            // Set the content type, as it comes from the server
            Header[] headers = method.getResponseHeaders();
            for (Header header : headers) {

                if ("Content-Type".equalsIgnoreCase(header.getName())) {
                    response.setContentType(header.getValue());
                }
            }

            // Write the body, flush and close
            writer.write(method.getResponseBodyAsString());
            writer.flush();
            writer.close();
        } catch (HttpException e) {

            //log.error("Oops, something went wrong in the HTTP proxy", null, e);
            writer.write(e.toString());
            throw e;

        } catch (IOException e) {

            e.printStackTrace();
            writer.write(e.toString());
            throw e;
        }
    }
}
