package kr.co.vwa.common.util;

import java.lang.reflect.Type;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Created by junypooh on 2018-01-18.
 * <pre>
 * kr.co.vwa.common.util
 *
 * JSON 관련 Class
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-18 오후 1:37
 */
public class JsonUtils {

    private static Gson gson = null;

    private static Gson gsonText = null;

    static {
//        GsonBuilder gsonBuilder = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().setPrettyPrinting();
        GsonBuilder gsonBuilder = new GsonBuilder().setPrettyPrinting();
        gson = gsonBuilder.create();

        GsonBuilder gsonBuilderText = new GsonBuilder();
        gsonText = gsonBuilderText.create();
    }

    /**
     * JSON Serialize 메쏘드
     *
     * @param o 오브젝트
     * @return JSON 스트링
     */
    public static String toJson(Object o) {
        if (o instanceof String) {
            return gsonText.toJson(fromJson((String) o));
        } else {
            return gsonText.toJson(o);
        }
    }

    /**
     * json 데이터를 pretty 포맷의 문자열을 반환한다.
     *
     * @param o JSON 오브젝트
     * @return String
     */
    public static String toPrettyJson(Object o) {
        if (o instanceof String) {
            return gson.toJson(fromJson((String) o));
        } else {
            return gson.toJson(o);
        }
    }

    /**
     * JSON Deserialize 메쏘드
     *
     * @param json    JSON 스트링
     * @param typeOfT 오브젝트 타입
     * @return 오브젝트
     */
    public static <T> T fromJson(String json, Type typeOfT) {

        T obj = null;
        try {
            obj = gson.fromJson(json, typeOfT);
        } catch (Exception e) {
            // ignore case
        }

        return obj;
    }

    /**
     * JSON 스트링의 JsonObject 변환 메쏘드
     *
     * @param json JSON 스트링
     * @return JsonObject
     */
    public static JsonObject fromJson(String json) {

        JsonObject obj = null;
        try {
            obj = new JsonParser().parse(json).getAsJsonObject();
        } catch (Exception e) {
            // ignore case
        }

        return obj;
    }
}
