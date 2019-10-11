Library ieee;
use ieee.std_logic_1164.all;

entity nBitAdder_tb is 
end nBitAdder_tb;

architecture behaviour of nbitAdder_tb is 

    component nBitAdder 
    generic(n : integer := 4);
        port(
            cin : in std_logic;
            a, b : in std_logic_vector(n-1 downto 0);
            sum : out std_logic_vector(n-1 downto 0);
            cout : out std_logic
        );
    end component;

    signal cin, cout : std_logic;
    signal a, b, sum : std_logic_vector(3 downto 0);

    begin
        
        -- instantiating the component to be tests;
        -- just like throwing it down onto a test chip (test bench)
        nBitAdder_1: nBitAdder generic map(n => 4) port map(cin => cin, a => a, b => b, sum => sum, cout => cout);

        process
            
            -- define what a set of inputs will look like
            type input_type is record
                a, b, sum : std_logic_vector(3 downto 0);
                cin, cout : std_logic;
            end record;

            type input_array is array (natural range <>) of input_type;

            constant input_values : input_array :=
                (
                    ("0000", "0010", "0010", '0', '0'),
                    ("1000", "0001", "1001", '0', '0'),
                    ("1111", "0001", "0000", '0', '1'),
                    ("0000", "0000", "0000", '0', '0'));
            
            begin

                for i in input_values'range loop

                    cin <= input_values(i).cin;
                    a <= input_values(i).a;
                    b <= input_values(i).b;

                    wait for 100 ns;

                    assert sum = input_values(i).sum;
                        report "bad sum value" severity error;  

                    assert cout = input_values(i).cout;
                        report "bad overflow value" severity error;
                    
                end loop;

                assert false report "end of tests" severity note;
            wait;
        end process;
    end behaviour;
            

            