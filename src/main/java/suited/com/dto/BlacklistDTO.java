package suited.com.dto;

import java.text.SimpleDateFormat;

public class BlacklistDTO {
	private String id;
	private String name;
	private String black_update;
	private String reason;
	
	public BlacklistDTO() {}

	public BlacklistDTO(String id, String name, long black_update, String reason) {
		super();
		this.id = id;
		this.name = name;
		this.black_update = toStringDate(black_update);
		this.reason = reason;
	}
	
	public BlacklistDTO(String id, String name, String black_update, String reason) {
		super();
		this.id = id;
		this.name = name;
		this.black_update = black_update;
		this.reason = reason;
	}
	
	public String toStringDate(long black_update) {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	    return sdf.format(black_update);
	   }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBlack_update() {
		return black_update;
	}

	public void setBlack_update(String black_update) {
		this.black_update = black_update;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
	
}
