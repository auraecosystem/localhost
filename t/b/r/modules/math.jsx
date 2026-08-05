// math.js (The Module)
export function add(a, b) {
  return a + b;
}

// main.js (Consuming the Module)
import { add } from './math.js';
console.log(add(2, 3)); // Outputs: 5
