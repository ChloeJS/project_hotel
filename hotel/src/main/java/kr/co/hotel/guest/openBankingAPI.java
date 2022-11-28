package kr.co.hotel.guest;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.JsonObject;

// 네이버 API 예제 - 블로그 카테고리 조회

public class openBankingAPI {

	@Autowired
	ApiVO avo;
	
    public static void main(String[] args) {
    	try {
    		//bankingRealNameApi(new HashMap<String, String>());
    	} catch (Exception e) {
    		System.out.println(e.toString());
    	}
    }
    public String bankingRealNameApi(ApiVO avo, HttpSession sess) throws Exception {

		String code = "";		// 최종 return 될 코드 값

		Random random = new Random();
		int n = random.nextInt(999999999);	// bank_tran_id(거래고유번호) 뒤의 임의 난수값으로 사용하기 위해

		HttpURLConnection conn = null;
		JSONObject responseJson = null;

		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		Calendar calendar = Calendar.getInstance();
		String time = df.format(calendar.getTime());

		try {
			
            // 요청할 api url
			URL url = new URL("https://testapi.openbanking.or.kr/v2.0/inquiry/real_name");

			conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json;charset=UTF-8 ");
			/* conn.setRequestProperty("Date",time); */
			conn.setRequestProperty("Transfer-Encoding", "chunked");
			conn.setRequestProperty("Connection", "keep-alive\"");
			// token 값 header에 넣어주기
			conn.setRequestProperty("Authorization", "BearereyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJNMjAyMjAxNTYwIiwic2NvcGUiOlsib29iIl0sImlzcyI6Imh0dHBzOi8vd3d3Lm9wZW5iYW5raW5nLm9yLmtyIiwiZXhwIjoxNjc3Mzk4MzkyLCJqdGkiOiI5MGRiYzNlMS1lZDNkLTQ3MjQtOTJiZi1lMmRjN2QyNGIxNWQifQ.pMI9ErxbgIB77AoUH-nh-DYefYBsZOLRV417ijb8vN4");
            // POST 방식 사용을 위해
			conn.setDoOutput(true);

			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));

			// 추후 parameter mapping 필요
			String bank_or_id = "M202201560";
			String bank_tran_id = bank_or_id+"U"+n;
			//String bank_tran_id = "M202201560U023162515";
			
			JsonObject params = new JsonObject();
			
			params.addProperty("bank_code_std", avo.getBank_code_std());
			params.addProperty("account_num", avo.getAccount_num());
			params.addProperty("account_holder_info_type", "");
			params.addProperty("account_holder_info", avo.getAccount_holder_info());
			params.addProperty("bank_tran_id", bank_tran_id);
			params.addProperty("tran_dtime", time);
			
			 
			bw.write(params.toString());
			bw.flush();
			bw.close();

			int responseCode = conn.getResponseCode();
			if (responseCode == 200) {

				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				StringBuilder sb = new StringBuilder();
				String line = "";
				while ((line = br.readLine()) != null) {
					sb.append(line);
				}
				JSONParser jparser = new JSONParser();
				responseJson = (JSONObject) jparser.parse(sb.toString());
				code = (String) responseJson.get("rsp_code");
				// 응답 데이터
				System.out.println("responseJson :: " + sb.toString());
				System.out.println("rsp_code :: " + code);
            // 아래 else 이후 코드는 입력하지 않아도 됨
			} else {
				code = "9999";
			}
			sess.setAttribute("code",code);
			for (int i =0; i<responseJson.size(); i++) {
				JSONObject js = new JSONObject(responseJson);
				avo.setAccount_holder_name(js.get("account_holder_name").toString());
			}
			
			
			
//			JSONObject name = new JSONObject(responseJson);
//			avo.setAccount_holder_name(name);
			System.out.println("sesstion에 전달하는 코드는 :"+code);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}


		return code;
	}
}