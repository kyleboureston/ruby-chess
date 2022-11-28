# frozen_string_literal: true

# monkey patch String class to colorize text
class String
    def red;                  "\e[31m#{self}\e[0m" end
    def green;                "\e[32m#{self}\e[0m" end
    def yellow;               "\e[33m#{self}\e[0m" end
    def purple;               "\e[34m#{self}\e[0m" end
    def pink;                 "\e[35m#{self}\e[0m" end
    def blue;                 "\e[36m#{self}\e[0m" end
    def white;                "\e[37m#{self}\e[0m" end

    def bg_gray_even;         "\e[40m#{self}\e[0m" end
    def bg_gray_odd;          "\e[40m#{self}\e[0m" end
    def bg_dark_gray_even;    "\e[100m#{self}\e[0m" end
    def bg_dark_gray_odd;     "\e[100m#{self}\e[0m" end

    def bold;                 "\e[1m#{self}\e[22m" end
    def italic;               "\e[3m#{self}\e[23m" end
    def underline;            "\e[4m#{self}\e[24m" end
    def blink;                "\e[5m#{self}\e[25m" end
    def reverse_color;        "\e[7m#{self}\e[27m" end
end
