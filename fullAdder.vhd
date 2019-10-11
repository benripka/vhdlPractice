
entity adder is 
    -- i0 and i1 are the two input numbers, ci is the carry bit, s is the output and c0 is the carry output
    port(i0, i1: in bit; ci: in bit; s: out bit; c0 : out bit);
end adder;

architecture rtl of adder is 
begin
    -- this part computes the sum
    s <= i0 xor i1 xor ci;
    -- compute the carry
    c0 <= (i0 and i1) or (i0 and ci) or (i1 and ci);
end rtl;


