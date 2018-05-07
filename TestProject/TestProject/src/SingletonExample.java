public class SingletonExample {

	private static SingletonExample singleton = null;



	private SingletonExample() {

	}

	public static SingletonExample getInstance() {
		if (singleton == null) {
			singleton=new SingletonExample();
		}
		return singleton;
	}
}
