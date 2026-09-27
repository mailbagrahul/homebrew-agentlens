cask "agentlens" do
  version "0.1.1"
  sha256 "712581b681e0e37426f7c2c78ce175df264f39d85e10c2aad8fc2ecf6e7b14ad"

  url "https://github.com/mailbagrahul/AgentLens-releases/releases/download/v#{version}/AgentLens-#{version}.zip"
  name "AgentLens"
  desc "Notch + menu bar monitor for AI coding agents"
  homepage "https://github.com/mailbagrahul/AgentLens-releases"

  depends_on macos: :sonoma

  # Sparkle updates the app in place; brew shouldn't fight it.
  auto_updates true

  app "AgentLens.app"

  uninstall quit: "dev.agentlens.app"

  # ~/.agentlens is left alone on purpose: Claude Code hooks installed by
  # AgentLens point into it, and removing it would break every hook call.
  zap trash: [
    "~/Library/Caches/dev.agentlens.app",
    "~/Library/HTTPStorages/dev.agentlens.app",
    "~/Library/Preferences/dev.agentlens.app.plist",
  ]

  caveats <<~EOS
    AgentLens is ad-hoc signed (not notarized yet). If macOS says it cannot
    verify the developer on first launch, open System Settings › Privacy &
    Security and click "Open Anyway", then launch it again.

    After that the app updates itself (daily check, or Check for Updates…
    in its menu-bar menu). `brew upgrade --cask agentlens` also works.
  EOS
end
