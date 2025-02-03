<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

An Asynchronous FIFO is a specialized memory buffer used for data transfer between two clock domains operating at different frequencies. It consists of a write clock domain, where data is written using a write clock (w_clk), and a read clock domain, where data is read using a separate read clock (r_clk). The FIFO includes a memory array to store data, along with write and read pointers to track where data is written and read. Additionally, it features empty and full flags to prevent underflow and overflow conditions. The synchronization logic ensures safe data transfer between the two clock domains, preventing metastability issues. When data is written, the write pointer advances, and when data is read, the read pointer moves forward. If the write pointer catches up to the read pointer, the FIFO is full, preventing further writes. Conversely, if the read pointer matches the write pointer, the FIFO is empty, stopping further reads. Special synchronization techniques, such as Gray-coded pointers, help in reliable communication between clock domains, ensuring data integrity.

## How to test

To use the Asynchronous FIFO project, first, set up the system with two different clock domains—one for writing (w_clk) and one for reading (r_clk). Since these clocks operate at different frequencies, the FIFO ensures smooth data transfer between them. When w_clk is active, data is written into the FIFO, and the write pointer increments to the next memory location. If the FIFO reaches its maximum capacity, the full flag is triggered, preventing further writes until space becomes available. Similarly, when r_clk is active, data is read from the FIFO, and the read pointer advances. If no data is available, the empty flag is set, blocking further reads until new data is written. Since the write and read pointers exist in different clock domains, synchronization techniques, such as Gray-coded pointers, ensure reliable data transfer without metastability issues. To integrate the FIFO into a system, connect it to a producer module that writes data and a consumer module that reads it, ensuring data flow is properly managed by monitoring the full and empty flags. Testing and simulation in Verilog are crucial to verify that the FIFO correctly handles data transfer, prevents overflow and underflow, and operates efficiently across different clock domains. This project is particularly useful in high-speed data buffering, communication systems, and clock domain crossing scenarios.

## External hardware

List external hardware used in your project (e.g. PMOD, LED display, etc), if any
