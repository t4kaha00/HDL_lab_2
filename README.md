
# System Modelling and Synthesis with HDL


## 4-bit counter
- The output count increases in the next clock cycle when dir=0, and vice versa; count decreases when dir=1.
- When overflow(or underflow) happens, in the next clock cycle, set output over=1 and count=D’0 or count=D’15, if direction is upwards (dir=0) or downwards (dir=1).
- Ensure that in the clock cycle after, reset the output over to 0.
- When load=1 and enable=1, the counter loads the 4-bit vector from data and stores it into count.
- Where, count t is count at clock t; count t+1 /over t+1 is count/over of the next clock;
- Q is the value of count at clocked time t; and Q_data is the value of data at time t;
- “–” means any value; D’15 means unsigned decimal value 15; B’1 means binary value 1;
## 8-bit counter
In this track, we will extend the 4-bit counter to design a double-digit, bi-directional hexadecimal counter. Therefore, the counter output value range goes from 00 to FF.
- The output count is separated into two output signals:
- counter_lo_out : out std_logic_vector(3 downto 0)
- counter_hi_out : out std_logic_vector(3 downto 0)
- Thus, load operation occurs when both load_in and enable_in are b’1:
- counter_hi_out <= data_in (7 downto 4);
- counter_lo_out <= data_in (3 downto 0);
## PWM module
Design a Pulse Width Modulation (PWM) component with 8-bit resolution, with the following definition:
- Combine the outputs from 8bitcounter: count_lo_out & count_hi_out and map to the dc_in port of the pwm entity;
- then, use the output pwm_out from pwm to drive an LED on
the Zedboard in order to emulate the ambiance effect.
- Use DIP switches (SWx) for data_in port and push buttons (e.g., BTNU, BTNL, BTNR and BTNC) for the other input ports.
