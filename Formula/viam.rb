class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.89.0.tar.gz"
  sha256 "6db492507317c4beceab0f706aef2d643a351588ee6e8f4ab583fddc3d9aac2f"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 22
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "46e53832123ea7a8e84e1df22e580bf2b2a3e20b64e2d052f5312a8594e07e62"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2e4c83153276d5e27e7c94aa6fb139f82fe5c7b4e47a95e77c6facbcb0483c98"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d8132e7445dcd296e58f9ac353802344e2c58081075235ec16e44c5263d28955"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
