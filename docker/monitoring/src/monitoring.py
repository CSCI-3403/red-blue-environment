import random
import subprocess
import time

from typing import Dict

from prometheus_client import start_http_server, Gauge

HOSTS = ["prod", "nonexistant"]

gauges: Dict[str, Gauge] = {}
for host in HOSTS:
    gauges[f"{host}_up"] = Gauge(f"{host}_up", "Can SSH into this machine")
    gauges[f"{host}_random"] = Gauge(f"{host}_random", "Can SSH into this machine")


def test():
    for host in HOSTS:
        process = subprocess.Popen(
            f"ssh -o LogLevel=ERROR -oStrictHostKeyChecking=no {host} /sbin/monitor.sh",
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE)
        stdout, stderr = process.communicate()

        gauges[f"{host}_up"].set(process.returncode)
        gauges[f"{host}_random"].set(random.random())

if __name__ == '__main__':
    start_http_server(9090)

    while True:
        test()
        time.sleep(2)
