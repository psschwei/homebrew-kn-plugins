require 'fileutils'

class Func < Formula
  v = "v1.9.0"
  plugin_name = "func"
  path_name = "#{plugin_name}"
  file_name = "#{plugin_name}"
  base_url = "https://github.com/knative/#{path_name}/releases/download/knative-#{v}"

  homepage "https://github.com/knative/#{path_name}"

  version v

  if OS.mac?
    if `uname -m`.chomp  == "arm64"
      url "#{base_url}/#{file_name}_darwin_arm64"
      sha256 "bd6664b44554074d5ea95f10a3e878abb9d455f34393b2cbed5381b470db8d5b"
    else
      url "#{base_url}/#{file_name}_darwin_amd64"
      sha256 "9b629259fb7fa93d7f6f84b86b085fc374a0b76f8afbb3cc3eb43660d1c6985c"
    end
  end

  if OS.linux?
    if `uname -m`.chomp  == "arm64"
      url "#{base_url}/#{file_name}_linux_arm64"
      sha256 "c9719fe19b20bc28d6fd9c2d351ee696acba6219017574ced0c9a9e54ac4f136"
    else
      url "#{base_url}/#{file_name}_linux_amd64"
      sha256 "d89343bdd012da1e38af934f62610fc49b5fe6633f077589c9259c21d66a8d57"
    end
  end

  def install
    if OS.mac?
      if `uname -m`.chomp == "arm64"
        FileUtils.mv("func_darwin_arm64", "kn-func")
      else
        FileUtils.mv("func_darwin_amd64", "kn-func")
      end
    end
    if OS.linux?
      if `uname -m`.chomp == "arm64"
        FileUtils.mv("func_linux_arm64", "kn-func")
      else
        FileUtils.mv("func_linux_amd64", "kn-func")
      end
    end
    p "Installing kn-func binary in " + bin
    bin.install "kn-func"
    p "Installing func symlink in " + bin
    ln_s "kn-func", bin/"func"
  end

  test do
    system "#{bin}/kn-func", "version"
  end
end

