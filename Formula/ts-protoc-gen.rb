require "language/node"

class TsProtocGen < Formula
  desc "A protoc plugin that generates TypeScript declarations."
  homepage "https://www.npmjs.com/package/ts-protoc-gen"
  url "https://registry.npmjs.org/ts-protoc-gen/-/ts-protoc-gen-0.15.0.tgz"
  sha256 "6dce82962ab9491a4c2fec56a6e19d0302fac3ca7da4ca6bd8a07f4784235602"
  license "Apache-2.0"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do

  end
end
