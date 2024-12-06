/**
 * @author: Ky Kingslien
 * 
 */


// Create object to play keyboard sound
const keyboardSound = new Audio('keyboard.mp3');

// Define a class for the calculator
class Calculator {
    // Constructor function to initialize the calculator
    constructor() {

        // Initialize the calculator with result and time display elements
        this.result = document.getElementById("inputext");
        this.timeDisplay = document.getElementById("time");
        this.dateDisplay = document.getElementById("date");

        // Update time and date every second
        this.updateTime();
        this.updateDate();
        setInterval(() => {
            this.updateTime();
            this.updateDate();
        }, 1000); // Update time and date every second
    }

    // Method to update the time display
    updateTime() {
        // Get the current date and time using Date()
        const today = new Date();
        let hours = today.getHours();
        const minutes = today.getMinutes();
        const ampm = hours >= 12 ? 'PM' : 'AM';

        // Convert 24-hour time to 12-hour time
        hours = hours % 12 || 12;

        // Ensure minutes and hours are in two-digit format
        const formattedMinutes = minutes < 10 ? "0" + minutes : minutes;
        const formattedHours = hours < 10 ? "0" + hours : hours;

        // Create a formatted time string
        const timeString = formattedHours + ":" + formattedMinutes + " " + ampm;

        // Update the time display element
        this.timeDisplay.innerHTML = timeString;
    }

    // Method to update the date display
    updateDate() {
        // Get the current date
        const today = new Date();

        // Get the day, month, and year
        const day = today.getDate();
        const month = today.getMonth() + 1; // Adding 1 because getMonth() returns zero-based month
        const year = today.getFullYear();

        // Ensure day, month, and year are in two-digit format
        const formattedDay = day < 10 ? "0" + day : day;
        const formattedMonth = month < 10 ? "0" + month : month;

        // Create a formatted date string in MM/DD/YYYY format
        const dateString = formattedMonth + "/" + formattedDay + "/" + year;

        // Update the date display element
        this.dateDisplay.innerHTML = dateString;
    }

    // Additional method for date-related calculations
    calculateDate(operation, days) {
        try {
            const currentDate = new Date();

            if (operation === 'add') {
                currentDate.setDate(currentDate.getDate() + days);
            } else if (operation === 'subtract') {
                currentDate.setDate(currentDate.getDate() - days);
            }

            // Display the updated date in MM/DD/YYYY format
            this.dateDisplay.innerHTML = (currentDate.getMonth() + 1) + "/" + currentDate.getDate() + "/" + currentDate.getFullYear();
        } catch (err) {
            // Handle errors by displaying an error message
            this.displayMessage("ERROR!");
        }
    }

    // Method to display an ERROR! message
    displayMessage(message) {
        this.result.value = message;

        // Clear the message after 3 seconds
        setTimeout(() => {
            this.result.value = "";
        }, 3000);
    }


    // Method to handle different calculator operations
    calculate(number) {

        // Play the keyboard sound
        keyboardSound.play();

        // Check if the current expression length exceeds the limit (12 digits)
        if (this.result.value.length >= 12) {
            // Display an error message or take appropriate action
            this.displayMessage("Max. 12 digits");
            return;
        }
        
        if (number === 'Math.sqrt') {
            // Handle square root separately
            this.result.value += '√';

        } else if (number === 'log10') {
            // Handle base 10 logarithm
            this.result.value += 'log10(';

        } else if (number === 'Math.log') {
            // Handle natural logarithm (ln)
            this.result.value += 'ln(';

        } else if (number === 'Math.cos') {
            // Handle cosine function
            this.result.value += 'cos(';

        } else if (number === 'Math.sin') {
            // Handle sine function
            this.result.value += 'sin(';

        } else if (number === 'Math.tan') {
            // Handle tangent function
            this.result.value += 'tan(';

        } else if (number === '**2') {
            // Handle exponentiation (x^2)
            this.result.value += '^2';

        } else if (number === '**') {
            // Handle exponentiation (x^y)
            this.result.value += '^';

        } else {
            // Append the numeric value
            this.result.value += number;

            // Replace operators for display
            const displayValue = this.result.value;
            // Replace `*` with `x` and `/` with '÷'
            const formattedDisplay = displayValue.replace(/\*/g, 'x').replace(/\//g, '÷');
            this.result.value = formattedDisplay;
        }

    }

   

    // Method to calculate the result of the expression
    calculateResult() {

        // Play the keyboard sound
        keyboardSound.play()

        try {
            // Replace custom symbols with standard operators
            const expression = this.result.value
                .replace(/x/g, '*')
                .replace(/÷/g, '/')
                .replace(/log10\(/g, 'Math.log10(')
                .replace(/ln\(/g, 'Math.log(')
                .replace(/cos\(/g, 'Math.cos(')
                .replace(/sin\(/g, 'Math.sin(')
                .replace(/tan\(/g, 'Math.tan(')
                .replace(/√\((-?\d+(?:\.\d+)?)\)/g, 'Math.sqrt($1)')
                .replace(/√(-?\d+(?:\.\d+)?)/g, 'Math.sqrt($1)')
                .replace(/(-?\d+(?:\.\d+)?)%/g, '($1/100)')
                .replace(/\^2/g, '**2')  // handle (x^2) 
                .replace(/\^/g, '**');// handle (x^y)

            // Evaluate the expression using eval
            let result = eval(expression).toString();

            // Check if the result is an integer and has more than three digits
            if (/^-?\d+$/.test(result) && result.length > 3) {
                // Format the integer with backticks every three digits
                result = result.split('').reverse().map((digit, index) => (index !== 0 && index % 3 === 0) ? digit + '`' : digit).reverse().join('');
            }


            // Truncate the result to 12 characters
            result = result.slice(0, 12);

            // Display the result
            this.result.value = result;

            // Play the keyboard sound after a slight delay 
            // to prevent overlapping sounds
            setTimeout(() => {
                keyboardSound.play();
            }, 100);

        } catch (err) {
            // Handle errors by displaying an error message
            this.displayMessage("ERROR!");
        }
    }

    // Method to clear the calculator display when using `C` button
    clear() {
        this.result.value = "";

        // Play the keyboard sound after a slight delay
        setTimeout(() => {
            keyboardSound.play();
        }, 100);
    }

    // Method to delete the last character display when using the back arrow button
    deleteLast() {
        this.result.value = this.result.value.slice(0, -1);

        // Play the keyboard sound after a slight delay
        setTimeout(() => {
            keyboardSound.play();
        }, 100);
    }

    // Method to toggle the sign of the current operand when using `+/-` button
    toggleSign() {

        // Get the current value in the calculator display
        let currentValue = this.result.value;

        // Handle different cases for toggling the sign
        if (currentValue === "" || currentValue === "0" || currentValue === "-0") {
            // Handle different cases for toggling the sign
            this.result.value = "-";

        } else if (!isNaN(currentValue.charAt(currentValue.length - 1))) {
            // If the last character is a number, toggle the sign for the last operand
            const lastOperatorIndex = currentValue.lastIndexOf("+") || currentValue.lastIndexOf("-") || currentValue.lastIndexOf("*") || currentValue.lastIndexOf("/");
            const lastOperand = currentValue.slice(lastOperatorIndex + 1);
            this.result.value = currentValue.slice(0, lastOperatorIndex + 1) + (lastOperand.charAt(0) === '-' ? lastOperand.slice(1) : '-' + lastOperand);

        } else {
            // If the last character is not a number, add a minus sign
            this.result.value += "-";
        }

        // Play the keyboard sound after a slight delay
        setTimeout(() => {
            keyboardSound.play();
        }, 100);
    }

}

// Create an instance of the Calculator class
const calculator = new Calculator();
