import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.Test;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class RunnerRestfulBooker {
    @Test
    public void testRunner() throws IOException {
        Results results = Runner.path("src/test/java/restfulBooker")
                .outputCucumberJson(true)
                .parallel(4);
        generateReport(results.getReportDir());
    }
    @Test
    public void testRunnerUnHappyPathss() throws IOException {
        Results results = Runner.path("src/test/java/restfulBooker")
                .tags("@UnHappyPaths")
                .outputCucumberJson(true)
                .parallel(1);
        generateReport(results.getReportDir());
    }
    @Test
    public void testRunnerHappyPaths() throws IOException {
        Results results = Runner.path("src/test/java/restfulBooker")
                .tags("@HappyPaths")
                .outputCucumberJson(true)
                .parallel(1);
        generateReport(results.getReportDir());
    }
    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "test-automatization-api");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}

