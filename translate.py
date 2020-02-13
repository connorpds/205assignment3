import sys, math
def twos_complement(hexstr,bits):
    value = int(hexstr,16)
    if value & (1 << (bits-1)):
        value -= 1 << bits
    return value

def main():
    num_input = str(sys.argv[1])
    maxtolerance = math.sin(math.pi/256)
    num = twos_complement(num_input,32)
    num = num/(2**16)
    print ("angle is", num)
    sin_supposed = math.sin(num)
    print("sin supposed to be", sin_supposed)
    program_calc_sin = twos_complement("0xf4f4",32)
    program_calc_sin = program_calc_sin/(2**16)
    print("program calculated sin as", program_calc_sin)
    print("within tolorance?", abs(program_calc_sin-sin_supposed)<maxtolerance)
    cos_supposed = math.cos(num)
    print("cos supposed to be", cos_supposed)
    program_calc_cos = twos_complement("0xffffdd8d",32)
    program_calc_cos = program_calc_cos/(2**16)
    print("program calculated cos as", program_calc_cos)
    print("cos within tolorance?", abs(program_calc_cos-cos_supposed)<maxtolerance)
    # import math
    # num = 1
    # print(hex(int(num*(2**16))))

if __name__ == '__main__':
    main()
