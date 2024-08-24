package com.java.example;

import org.junit.Test;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThrows;

public class CalculatorTest {

    // Test for addition
    @Test
    public void testAdd() {
        Calculator calculator = new Calculator();
        int result = calculator.add(2, 3);
        assertEquals(5, result);
    }

    // Test for subtraction
    @Test
    public void testSubtract() {
        Calculator calculator = new Calculator();
        int result = calculator.subtract(5, 3);
        assertEquals(2, result);
    }

    // Test for multiplication
    @Test
    public void testMultiply() {
        Calculator calculator = new Calculator();
        int result = calculator.multiply(2, 3);
        assertEquals(6, result);
    }

    // Test for division
    @Test
    public void testDivide() {
        Calculator calculator = new Calculator();
        int result = calculator.divide(6, 3);
        assertEquals(2, result);
    }

    // // Test for division by zero
    // @Test
    // public void testDivideByZero() {
    //     Calculator calculator = new Calculator();
    //     assertThrows(IllegalArgumentException.class, () -> {
    //         calculator.divide(6, 0);
    //     });
    // }
}
