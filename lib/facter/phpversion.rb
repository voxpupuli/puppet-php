Facter.add(:phpversion) do
  setcode do
    Facter::Util::Resolution.exec('php -v').
      split("\n").first.split(' ').
      select { |x| x =~ /^(?:(\d+)\.)(?:(\d+)\.)?(\*|\d+)/ }.first
  end
end
