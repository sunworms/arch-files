import decman
from pathlib import Path
import pwd
from decman.plugins import systemd

class Commands(systemd.SystemdCommands):
    @staticmethod
    def _as_user(user: str, *args: str) -> list[str]:
        uid = pwd.getpwnam(user).pw_uid
        return [
            "runuser", "-u", user, "--",
            "env", f"XDG_RUNTIME_DIR=/run/user/{uid}",
            f"DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/{uid}/bus",
            "systemctl", "--user", *args,
        ]

    def enable_user_units(self, units, user):
        return self._as_user(user, "enable", *units)

    def disable_user_units(self, units, user):
        return self._as_user(user, "disable", *units)

    def user_daemon_reload(self, user):
        return self._as_user(user, "daemon-reload")

decman.systemd.commands = Commands()

USER = "sunny"

systemd_services = Path("../enabled_services.txt").read_text().splitlines()

decman.systemd.enabled_units |= set(systemd_services)

user_services = Path("../enabled_user_services.txt").read_text().splitlines()

decman.systemd.enabled_user_units.setdefault(USER, set()).update(user_services)
