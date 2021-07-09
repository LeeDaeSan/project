package kafka.server.test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;

public class Config {
	
	HashMap<String, String> conf;

	public Config(String filePath) throws FileNotFoundException, IOException {
		conf = new HashMap<String, String>();
		File file = new File(filePath);
		
		BufferedReader br = new BufferedReader(new FileReader(file));
		String[] vals;
		
		String line = br.readLine();
		
		while (line != null) {
			if (!line.startsWith("#")) {
				vals=line.toLowerCase().split("=");
				conf.put(vals[0], vals[1]);
			}
			line=br.readLine();
		}

	}

	public String get(String key) {
		return conf.get(key.toLowerCase());
	}
}
