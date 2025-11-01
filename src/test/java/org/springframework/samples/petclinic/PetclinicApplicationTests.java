package org.springframework.samples.petclinic;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * Basic integration test for PetClinic application
 */
@SpringBootTest
class PetclinicApplicationTests {

    @Test
    void contextLoads() {
        // This test will pass if the Spring context loads successfully
    }
    
    @Test
    void applicationStarts() {
        // Basic application startup test
        assert true;
    }
}

