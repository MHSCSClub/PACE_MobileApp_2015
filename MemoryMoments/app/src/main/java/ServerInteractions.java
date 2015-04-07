import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

/**
 * Created by andrew on 4/7/15.
 */
public class ServerInteractions {
    public static String sendPost(String url, String data) throws Exception {
        String charset = "UTF-8";  // Or in Java 7 and later, use the constant: java.nio.charset.StandardCharsets.UTF_8.name()
        String param1 = data;
// ...

        String query = String.format("param1=%s",
        URLEncoder.encode(param1, charset));
        URLConnection connection = new URL(url).openConnection();
        connection.setDoOutput(true); // Triggers POST.
        connection.setRequestProperty("Accept-Charset", charset);
        connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=" + charset);

        try (OutputStream output = connection.getOutputStream()) {
            output.write(query.getBytes(charset));
        }

        InputStream response = connection.getInputStream();

        String resp = response.toString();

        return resp.split("\\[")[1];
    }
}
