import { Injectable } from '@nestjs/common';
import { CreateFintechDto } from './dto/create-fintech.dto';
import { UpdateFintechDto } from './dto/update-fintech.dto';
import { Sequelize } from 'sequelize-typescript';
import { QueryTypes } from 'sequelize';

@Injectable()
export class FintechService {
  constructor(private sequelize: Sequelize) {}
  async createFintech(CreateFintechDto: CreateFintechDto): Promise<any> {
    try {
      const [result, _] = await this.sequelize.query(
        'INSERT INTO payment.fintech (fint_code, fint_name) VALUES (:fint_code, :fint_name)',
        {
          replacements: {
            fint_code: CreateFintechDto.fint_code,
            fint_name: CreateFintechDto.fint_name,
          },
        },
      );

      const success = {
        message: 'Sukses membuat Fintech',
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

  async findAllFintech() {
    try {
      const data = await this.sequelize.query('select * from payment.fintech ');
      const success = {
        message: 'sukses',
        data: data[0],
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

  async findOneFintech(id: number): Promise<any> {
    try {
      const [data, _]: any[] = await this.sequelize.query(
        'SELECT * FROM payment.fintech WHERE fint_entity_id = :fint_entity_id',
        {
          replacements: {
            fint_entity_id: id,
          },
          type: QueryTypes.SELECT,
        },
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

  async updateFintech(
    id: number,
    UpdateFintechDto: UpdateFintechDto,
  ): Promise<any> {
    try {
      const [result, _] = await this.sequelize.query(
        'UPDATE payment.fintech SET fint_code = :fintCode, fint_name = :fintName WHERE fint_entity_id = :fint_entity_id',
        {
          replacements: {
            fint_entity_id: id,
            fintCode: UpdateFintechDto.fint_code,
            fintName: UpdateFintechDto.fint_name,
          },
        },
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

  async deleteFintech(id: number): Promise<any> {
    try {
      const result: any = await this.sequelize.query(
        'DELETE FROM payment.fintech WHERE fint_entity_id = :fint_entity_id',
        {
          replacements: {
            fint_entity_id: id,
          },
        },
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
