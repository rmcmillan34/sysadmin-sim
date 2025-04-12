## 🏷️ Base Image Release Tags

Base container images are published to GitHub Container Registry (GHCR) and versioned using a standardised naming format to support multi-distro and multi-architecture compatibility.

### 🔖 Tag Format

`base-<distro>-<version>-<arch>`


### 📋 Tag Components

| Component    | Description                              | Example         |
|--------------|------------------------------------------|-----------------|
| `<distro>`   | Target base OS (e.g., `ubuntu`, `fedora`) | `ubuntu`        |
| `<version>`  | Stable major release only (no beta/rolling) | `22.04`, `39` |
| `<arch>`     | CPU architecture (`amd64`, `arm64`)       | `arm64`         |

### ✅ Example Tags

- `base-ubuntu-22.04-amd64`
- `base-fedora-39-arm64`
- `base-debian-12-amd64`
- `base-alpine-3.18-arm64`
- `base-raspbian-2024-arm64`

> 📦 These tags are also used in GitHub Releases and pushed directly to `ghcr.io/rmcmillan34/<image>`.

### 🎯 Purpose

- Align CI/CD outputs with predictable versioning
- Allow tickets to declare compatible image targets
- Improve traceability between containers, tickets, and curriculum

---

### 📚 Related Design Decision

See [`design-decisions.md`](design-decisions.md) → **[DD-010] Base Image Release Tag Format** for rationale and tagging policy.

