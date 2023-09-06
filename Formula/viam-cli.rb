class ViamCli < Formula
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  version = "0.8.0"
  os_name = OS.linux? ? "linux" : "darwin"
  platform = "#{os_name}-#{arch}"
  desc "CLI for admin tasks in your Viam account"
  homepage "https://docs.viam.com/manage/cli/"
  shas = {
    "linux-amd64" => "5d4759f18ed4772dadf72aa318b503bfb7e2f963ed9553ce7d4cea45c0caed93"
  }
  sha256 shas[platform]
  url "https://storage.googleapis.com/packages.viam.com/apps/viam-cli/viam-cli-v#{version}-#{platform}"

  def install
    bin.install "packages.viam.com" => "viam"
  end
end
