package kafka.server.test;

import java.io.DataOutputStream;
import java.io.FileOutputStream;

public class MakeBinaryFile {
	public static void main(String[] args) throws Exception {
	    // 1) FileOutputStream 객체 생성
	    String filename = "/Users/daesan/app/kafka/out2.bin";
	    DataOutputStream out = new DataOutputStream(new FileOutputStream(filename));

	    // byte 배열이 아닌 정수 배열이어야, byte 데이터가 제대로 입력됨
	    int[] b = { 0x01, 0x02, 0x03, 0x04, 0x0D, 0x0A, 0x00, 0xFF };


	    // 위의 int배열의 요소를 하나씩 꺼내어,
	    // 바이트 형식으로 파일에 저장
	    for (int i = 0; i < b.length; i++)
	      out.write(b[i]);


	    out.close(); // 파일 닫기
	   
	  }
}
