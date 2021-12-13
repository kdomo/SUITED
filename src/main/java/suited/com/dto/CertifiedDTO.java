package suited.com.dto;

public class CertifiedDTO {

	private String id;
	private String idHash;
	private String idHashChecked;
	
	public CertifiedDTO() {}
	
	public CertifiedDTO(String id, String idHash, String idHashChecked) {
		super();
		this.id = id;
		this.idHash = idHash;
		this.idHashChecked = idHashChecked;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getIdHash() {
		return idHash;
	}

	public void setIdHash(String idHash) {
		this.idHash = idHash;
	}

	public String getIdHashChecked() {
		return idHashChecked;
	}

	public void setIdHashChecked(String idHashChecked) {
		this.idHashChecked = idHashChecked;
	}
	
}
