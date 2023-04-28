package;

using Lambda;

class StringKebabToCamelIdRenderer implements IdRendererInterface<String> 
{
	private var pref: String;

    public function new(pref: String = "") {
        this.pref = pref;
    }

	public function renderId(id: String): String {
		return pref + id.split("")
			.fold((c: String, res: {s: String, uc: Bool}) 
				-> (c == '-') 
					? {s: res.s, uc: true}
					: ((res.uc == true) 
						? {s: res.s + c.toUpperCase(), uc: false}
						: {s: res.s + c, uc: false}), {s: "", uc: false}).s;
	}

	public function parseId(id: String): String {
		if(id.indexOf(pref) != 0) throw IdParsingError.create(pref, id);
		return id.substr(pref.length)
			.split("")
			.fold((c, res) 
				-> ((c >= 'A') && (c <= 'Z')) 
					? res + '-' + c.toLowerCase() 
					: res + c, "");
	}
}