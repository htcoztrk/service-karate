package runner;


import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

class UsersTest {

    @Karate.Test
    Karate testUi() {
        return Karate.run("");
    }

    @Disabled("temporarily skipped – skiptestdeneme")
    @Test
    void skipScenario() {
        Runner.path("classpath:features")
                .tags("@skiptestdeneme")
                .parallel(1);
    }
}
