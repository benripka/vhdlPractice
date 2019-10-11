library ieee;
use ieee.std_logic_1164.all;

entity nBitAdder is 

    generic (n : integer := 4);

    port(
        cin : in std_logic;
        a, b : in std_logic_vector(n-1 downto 0);
        sum : out std_logic_vector(n-1 downto 0);
        cout : out std_logic
    );

end nBitAdder;

architecture structure of nBitAdder is 
    --define internal signals that will be needed.
    -- in this case it is the intermediate carry bits.
    signal intermediateCarry : std_logic_vector(1 to n-1);
    -- define the components that we will be using (maybe more than once) to make the nBitAdder
    component adder
        -- define the port interface to the custom adder component we'll be using
        port(
            i0, i1, ci : in std_logic; 
            s, co : out std_logic
        );
    end component;

    begin
        fullAdder_0 : adder port map(a(0), b(0), cin, sum(0), intermediateCarry(1));

        Generator1 : for i in 1 to n-2 generate 
            fullAdder_i : adder port map(a(i), b(i), intermediateCarry(i), sum(i), intermediateCarry(i + 1));
        end generate;
        fullAdder_n : adder port map(a(n-1), b(n-1), intermediateCarry(n-1), sum(n-1), cout);
    
    end structure;


