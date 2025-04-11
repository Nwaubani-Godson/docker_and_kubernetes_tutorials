# This script is designed to create CPU and memory load on the system.
# It will run indefinitely, so be careful when running it.
# To be on a safe side, add memory and cpu limits to the container.
import time
import threading

# Simulate CPU load
def cpu_task():
    while True:
        _ = 5 ** 2000

# Simulate memory usage
def memory_task():
    junk = []
    for _ in range(2000000):
        junk.append("A" * 1024)  # 1KB * 2M = ~2GB
        time.sleep(0.001)

# Run both in threads
threading.Thread(target=cpu_task).start()
threading.Thread(target=memory_task).start()
