import decman
from pathlib import Path

systemd_services = Path("../enabled_services.txt").read_text().splitlines()

decman.systemd.enabled_units |= set(systemd_services)
