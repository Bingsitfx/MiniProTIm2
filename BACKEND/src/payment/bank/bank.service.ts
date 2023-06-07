import { Injectable } from '@nestjs/common';
import { CreateBankDto } from './dto/create-bank.dto';
import { UpdateBankDto } from './dto/update-bank.dto';
import { Sequelize, } from 'sequelize-typescript';
import { QueryTypes } from 'sequelize';

@Injectable()
export class BankService {
  constructor(private sequelize: Sequelize) {}
  async createBank(createBankDto: CreateBankDto): Promise<any> {
    try {
      const [result, _] = await this.sequelize.query(
        'INSERT INTO payment.bank (bank_code, bank_name) VALUES (:bankCode, :bankName)',
        {
          replacements: {
            bankCode: createBankDto.bank_code,
            bankName: createBankDto.bank_name,
          },
        }
      );
  
      const success = {
        message: 'Sukses membuat Bank',
        status: 200,
        data: result,
      };
  
      return success;
    } catch (error) {
      const errorm = {
        message: error.message,
        status: 400,
      };
  
      return errorm;
    }
  }

  async findAllBank() {
    try {
      const data = await this.sequelize.query('select * from payment.bank ')
      const success = {
        message: 'sukses',
        data: data[0]
      }
      return success;
    } catch (error) {
      const errorm = {
        message: error.message,
        status: 400,
      };
  
      return errorm;
    }
  }

  async findOneBank(id: number): Promise<any> {
    try {
      const [data, _]:any[] = await this.sequelize.query(
        'SELECT * FROM payment.bank WHERE bank_entity_id = :bank_entity_id',
        {
          replacements: {
            bank_entity_id: id,
          },
          type: QueryTypes.SELECT,
        }
      );
  
      if (data.length === 0) {
        return {
          status: 404,
          message: 'Data bank tidak ditemukan',
        };
      }
  
      return data;
    } catch (error) {
      return {
        status: 400,
        message: error.message,
      };
    }
  }

  async updateBank(id: number, updateBankDto: UpdateBankDto): Promise<any> {
    try {
      const [result, _] = await this.sequelize.query(
        'UPDATE payment.bank SET bank_code = :bankCode, bank_name = :bankName WHERE bank_entity_id = :bank_entity_id',
        {
          replacements: {
            bank_entity_id: id,
            bankCode: updateBankDto.bank_code,
            bankName: updateBankDto.bank_name,
          },
        }
      );
  
      if (result[1] === 0) {
        return {
          status: 404,
          message: 'Data bank tidak ditemukan',
        };
      }
  
      const success = {
        message: 'Sukses mengupdate Bank',
        status: 200,
      };
  
      return success;
    } catch (error) {
      const errorm = {
        message: error.message,
        status: 400,
      };
  
      return errorm;
    }
  }

  async deleteBank(id: number): Promise<any> {
    try {
      const result:any = await this.sequelize.query(
        'DELETE FROM payment.bank WHERE bank_entity_id = :bank_entity_id',
        {
          replacements: {
            bank_entity_id: id,
          },
        }
      );
      
      if (result[1].rowCount === 0) {
        return {
          status: 404,
          message: 'Data bank tidak ditemukan',
        };
      }
      
      return {
        status: 200,
        message: 'Data bank berhasil dihapus',
      };
    } catch (error) {
      return {
        status: 400,
        message: error.message,
      };
    }
  }

}
