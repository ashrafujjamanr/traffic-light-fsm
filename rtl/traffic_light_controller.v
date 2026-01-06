module traffic_light_controller #(
    parameter int GREEN_TIME  = 10,
    parameter int YELLOW_TIME = 3,
    parameter int ALLRED_TIME = 2
)(
    input  wire clk,
    input  wire rst_n,

    output reg NS_red, NS_yellow, NS_green,
    output reg EW_red, EW_yellow, EW_green
);

    typedef enum logic [2:0] {
        S_NS_GREEN   = 3'd0,
        S_NS_YELLOW  = 3'd1,
        S_ALL_RED_1  = 3'd2,
        S_EW_GREEN   = 3'd3,
        S_EW_YELLOW  = 3'd4,
        S_ALL_RED_2  = 3'd5
    } state_t;

    state_t state, next_state;
    int timer;

    // State register + timer
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_NS_GREEN;
            timer <= 0;
        end
        else begin
            if (timer == 0) begin
                state <= next_state;
                case (next_state)
                    S_NS_GREEN:   timer <= GREEN_TIME;
                    S_NS_YELLOW:  timer <= YELLOW_TIME;
                    S_ALL_RED_1:  timer <= ALLRED_TIME;
                    S_EW_GREEN:   timer <= GREEN_TIME;
                    S_EW_YELLOW:  timer <= YELLOW_TIME;
                    S_ALL_RED_2:  timer <= ALLRED_TIME;
                endcase
            end else begin
                timer <= timer - 1;
            end
        end
    end

    // Next-state logic
    always @(*) begin
        case (state)
            S_NS_GREEN:   next_state = (timer==0) ? S_NS_YELLOW : S_NS_GREEN;
            S_NS_YELLOW:  next_state = (timer==0) ? S_ALL_RED_1 : S_NS_YELLOW;
            S_ALL_RED_1:  next_state = (timer==0) ? S_EW_GREEN : S_ALL_RED_1;
            S_EW_GREEN:   next_state = (timer==0) ? S_EW_YELLOW : S_EW_GREEN;
            S_EW_YELLOW:  next_state = (timer==0) ? S_ALL_RED_2 : S_EW_YELLOW;
            S_ALL_RED_2:  next_state = (timer==0) ? S_NS_GREEN : S_ALL_RED_2;
            default:      next_state = S_NS_GREEN;
        endcase
    end

    // Output logic
    always @(*) begin
        // default off
        NS_red=0; NS_yellow=0; NS_green=0;
        EW_red=0; EW_yellow=0; EW_green=0;

        case (state)
            S_NS_GREEN:   begin NS_green=1; EW_red=1; end
            S_NS_YELLOW:  begin NS_yellow=1; EW_red=1; end
            S_ALL_RED_1,
            S_ALL_RED_2:  begin NS_red=1; EW_red=1; end
            S_EW_GREEN:   begin EW_green=1; NS_red=1; end
            S_EW_YELLOW:  begin EW_yellow=1; NS_red=1; end
        endcase
    end

endmodule
